// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class Mutation_Create_repoMutation: GraphQLMutation {
  public static let operationName: String = "Mutation_Create_repo"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Mutation_Create_repo($input: CreateRepositoryInput!) { createRepository(input: $input) { __typename repository { __typename stargazerCount } } }"#
    ))

  public var input: CreateRepositoryInput

  public init(input: CreateRepositoryInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: GithubXAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GithubXAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createRepository", CreateRepository?.self, arguments: ["input": .variable("input")]),
    ] }

    /// Create a new repository.
    public var createRepository: CreateRepository? { __data["createRepository"] }

    /// CreateRepository
    ///
    /// Parent Type: `CreateRepositoryPayload`
    public struct CreateRepository: GithubXAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GithubXAPI.Objects.CreateRepositoryPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("repository", Repository?.self),
      ] }

      /// The new repository.
      public var repository: Repository? { __data["repository"] }

      /// CreateRepository.Repository
      ///
      /// Parent Type: `Repository`
      public struct Repository: GithubXAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { GithubXAPI.Objects.Repository }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("stargazerCount", Int.self),
        ] }

        /// Returns a count of how many stargazers there are on this object
        public var stargazerCount: Int { __data["stargazerCount"] }
      }
    }
  }
}
