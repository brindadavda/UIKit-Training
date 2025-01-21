// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetRepositoriesByUserNameQuery: GraphQLQuery {
  public static let operationName: String = "GetRepositoriesByUserName"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRepositoriesByUserName($username: String!) { user(login: $username) { __typename repositories(last: 10) { __typename id name description createdAt url stargazerCount } } }"#
    ))

  public var username: String

  public init(username: String) {
    self.username = username
  }

  public var __variables: Variables? { ["username": username] }

  public struct Data: CountryXAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { CountryXAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("user", User?.self, arguments: ["login": .variable("username")]),
    ] }

    public var user: User? { __data["user"] }

    /// User
    ///
    /// Parent Type: `User`
    public struct User: CountryXAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { CountryXAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("repositories", [Repository?]?.self, arguments: ["last": 10]),
      ] }

      public var repositories: [Repository?]? { __data["repositories"] }

      /// User.Repository
      ///
      /// Parent Type: `Repository`
      public struct Repository: CountryXAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { CountryXAPI.Objects.Repository }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", String?.self),
          .field("name", String?.self),
          .field("description", String?.self),
          .field("createdAt", String?.self),
          .field("url", String?.self),
          .field("stargazerCount", Int?.self),
        ] }

        public var id: String? { __data["id"] }
        public var name: String? { __data["name"] }
        public var description: String? { __data["description"] }
        public var createdAt: String? { __data["createdAt"] }
        public var url: String? { __data["url"] }
        public var stargazerCount: Int? { __data["stargazerCount"] }
      }
    }
  }
}
