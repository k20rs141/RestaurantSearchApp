import Foundation

final class HotPepperAPIService {
    @MainActor static let shared = HotPepperAPIService()

    func request(with urlString: String) async throws -> Gourmet {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpStatus = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            switch httpStatus.statusCode {
                case 200:
                    let gourmet = try JSONDecoder().decode(Gourmet.self, from: data)
                    return gourmet
                default:
                    throw APIError.invalidData
            }
        } catch {
            throw APIError.invalidData
        }
    }
}
