//
//  ViewController.swift
//  Working with JSON
//
//  Created by Kristina Korotkova on 01/03/23.
//

import UIKit

class ViewController: UIViewController {

    let urlStringBlackLotus = "https://api.magicthegathering.io/v1/cards?name=Black%20Lotus"
    let urlStringOpt = "https://api.magicthegathering.io/v1/cards?name=Opt"

    override func viewDidLoad() {
        super.viewDidLoad()

        printData(str: urlStringBlackLotus)
        printData(str: urlStringOpt)
    }

    func printData(str: String) {

        getData(urlString: str) { result in
            switch result {
            case .success(let card):
                guard let cardFirst = card.cards.first else { return }

                let str = """
                Names card: \(cardFirst.name)
                ManaCost: \(cardFirst.manaCost ?? "nil")
                cmc: \(cardFirst.cmc)
                set: \(cardFirst.set)
                subtypes: \(cardFirst.subtypes ?? ["nil"])
                """

                print(str)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func getData(urlString: String, completion: @escaping (Result<Cards, NetworkingError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badRequest))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serviceUnavailable))
            }

            guard let httpResponse = response as? HTTPURLResponse else { return }

            switch httpResponse.statusCode {
            case 200:
                guard let data = data else { return }

                do {
                    let cards = try JSONDecoder().decode(Cards.self, from: data)
                    completion(.success(cards))
                } catch {
                    completion(.failure(.jsonError))
                }
            case 400:
                completion(.failure(.badRequest))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            case 500:
                completion(.failure(.internalServerError))
            default:
                completion(.failure(.serviceUnavailable))
            }
        }.resume()
    }
}
