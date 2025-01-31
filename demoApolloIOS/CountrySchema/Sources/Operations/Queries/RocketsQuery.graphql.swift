// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RocketsQuery: GraphQLQuery {
  public static let operationName: String = "RocketsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query RocketsQuery { rockets { __typename id name height { __typename meters } mass { __typename kg } } }"#
    ))

  public init() {}

  public struct Data: CountrySchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { CountrySchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("rockets", [Rocket?]?.self),
    ] }

    public var rockets: [Rocket?]? { __data["rockets"] }

    /// Rocket
    ///
    /// Parent Type: `Rocket`
    public struct Rocket: CountrySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { CountrySchema.Objects.Rocket }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", CountrySchema.ID?.self),
        .field("name", String?.self),
        .field("height", Height?.self),
        .field("mass", Mass?.self),
      ] }

      public var id: CountrySchema.ID? { __data["id"] }
      public var name: String? { __data["name"] }
      public var height: Height? { __data["height"] }
      public var mass: Mass? { __data["mass"] }

      /// Rocket.Height
      ///
      /// Parent Type: `Distance`
      public struct Height: CountrySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { CountrySchema.Objects.Distance }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("meters", Double?.self),
        ] }

        public var meters: Double? { __data["meters"] }
      }

      /// Rocket.Mass
      ///
      /// Parent Type: `Mass`
      public struct Mass: CountrySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { CountrySchema.Objects.Mass }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("kg", Int?.self),
        ] }

        public var kg: Int? { __data["kg"] }
      }
    }
  }
}
