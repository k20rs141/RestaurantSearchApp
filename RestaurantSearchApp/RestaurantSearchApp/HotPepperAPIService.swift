import Foundation

final class HotPepperAPIService {
    static let shared = HotPepperAPIService()

    func request(with urlString: String) async throws -> Gourmet {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                throw APIError.invalidURL
            }

            switch httpStatus.statusCode {
                case 200:
                    let response = try JSONDecoder().decode(Gourmet.self, from: data)
                    return response
                default:
                    throw APIError.invalidResponse
            }
        } catch {
            throw APIError.invalidData
        }
    }
}
