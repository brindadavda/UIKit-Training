// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetWeatherByCityNameQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetWeatherByCityName($city: String!) {
      getCityByName(name: $city, config: {units: imperial}) {
        __typename
        name
        country
        weather {
          __typename
          summary {
            __typename
            title
            description
            icon
          }
          clouds {
            __typename
            all
            visibility
            humidity
          }
          temperature {
            __typename
            actual
            feelsLike
          }
        }
      }
    }
    """

  public let operationName: String = "GetWeatherByCityName"

  public var city: String

  public init(city: String) {
    self.city = city
  }

  public var variables: GraphQLMap? {
    return ["city": city]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getCityByName", arguments: ["name": GraphQLVariable("city"), "config": ["units": "imperial"]], type: .object(GetCityByName.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getCityByName: GetCityByName? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getCityByName": getCityByName.flatMap { (value: GetCityByName) -> ResultMap in value.resultMap }])
    }

    public var getCityByName: GetCityByName? {
      get {
        return (resultMap["getCityByName"] as? ResultMap).flatMap { GetCityByName(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getCityByName")
      }
    }

    public struct GetCityByName: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["City"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("weather", type: .object(Weather.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, country: String? = nil, weather: Weather? = nil) {
        self.init(unsafeResultMap: ["__typename": "City", "name": name, "country": country, "weather": weather.flatMap { (value: Weather) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var country: String? {
        get {
          return resultMap["country"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "country")
        }
      }

      public var weather: Weather? {
        get {
          return (resultMap["weather"] as? ResultMap).flatMap { Weather(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "weather")
        }
      }

      public struct Weather: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Weather"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("summary", type: .object(Summary.selections)),
            GraphQLField("clouds", type: .object(Cloud.selections)),
            GraphQLField("temperature", type: .object(Temperature.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(summary: Summary? = nil, clouds: Cloud? = nil, temperature: Temperature? = nil) {
          self.init(unsafeResultMap: ["__typename": "Weather", "summary": summary.flatMap { (value: Summary) -> ResultMap in value.resultMap }, "clouds": clouds.flatMap { (value: Cloud) -> ResultMap in value.resultMap }, "temperature": temperature.flatMap { (value: Temperature) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var summary: Summary? {
          get {
            return (resultMap["summary"] as? ResultMap).flatMap { Summary(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "summary")
          }
        }

        public var clouds: Cloud? {
          get {
            return (resultMap["clouds"] as? ResultMap).flatMap { Cloud(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "clouds")
          }
        }

        public var temperature: Temperature? {
          get {
            return (resultMap["temperature"] as? ResultMap).flatMap { Temperature(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "temperature")
          }
        }

        public struct Summary: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Summary"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("icon", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(title: String? = nil, description: String? = nil, icon: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Summary", "title": title, "description": description, "icon": icon])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          public var icon: String? {
            get {
              return resultMap["icon"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "icon")
            }
          }
        }

        public struct Cloud: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Clouds"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("all", type: .scalar(Int.self)),
              GraphQLField("visibility", type: .scalar(Int.self)),
              GraphQLField("humidity", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(all: Int? = nil, visibility: Int? = nil, humidity: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Clouds", "all": all, "visibility": visibility, "humidity": humidity])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var all: Int? {
            get {
              return resultMap["all"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "all")
            }
          }

          public var visibility: Int? {
            get {
              return resultMap["visibility"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "visibility")
            }
          }

          public var humidity: Int? {
            get {
              return resultMap["humidity"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "humidity")
            }
          }
        }

        public struct Temperature: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Temperature"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("actual", type: .scalar(Double.self)),
              GraphQLField("feelsLike", type: .scalar(Double.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(actual: Double? = nil, feelsLike: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "Temperature", "actual": actual, "feelsLike": feelsLike])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var actual: Double? {
            get {
              return resultMap["actual"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "actual")
            }
          }

          public var feelsLike: Double? {
            get {
              return resultMap["feelsLike"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "feelsLike")
            }
          }
        }
      }
    }
  }
}
