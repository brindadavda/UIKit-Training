// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserQuery: GraphQLQuery {
  public static let operationName: String = "User"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query User($login: String!) { user(login: $login) { __typename avatarUrl } }"#
    ))

  public var login: String

  public init(login: String) {
    self.login = login
  }

  public var __variables: Variables? { ["login": login] }

  public struct Data: GithubXAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GithubXAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("user", User?.self, arguments: ["login": .variable("login")]),
    ] }

    /// Lookup a user by login.
    public var user: User? { __data["user"] }

    /// User
    ///
    /// Parent Type: `User`
    public struct User: GithubXAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GithubXAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("avatarUrl", GithubXAPI.URI.self),
      ] }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: GithubXAPI.URI { __data["avatarUrl"] }
    }
  }
}
