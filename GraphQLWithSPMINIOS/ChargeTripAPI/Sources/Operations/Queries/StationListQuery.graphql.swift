// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StationListQuery: GraphQLQuery {
  public static let operationName: String = "StationList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StationList { stationList { __typename id address city owner { __typename name } } }"#
    ))

  public init() {}

  public struct Data: ChargeTripAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { ChargeTripAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("stationList", [StationList?]?.self),
    ] }

    /// Get a full list of stations.
    public var stationList: [StationList?]? { __data["stationList"] }

    /// StationList
    ///
    /// Parent Type: `Station`
    public struct StationList: ChargeTripAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { ChargeTripAPI.Objects.Station }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", ChargeTripAPI.ID.self),
        .field("address", String?.self),
        .field("city", String?.self),
        .field("owner", Owner?.self),
      ] }

      /// Unique ID of a station. This property is OCPI-compliant.
      public var id: ChargeTripAPI.ID { __data["id"] }
      /// Street/block name and house number if available. This property is OCPI-compliant.
      public var address: String? { __data["address"] }
      /// City or town. This property is OCPI-compliant.
      public var city: String? { __data["city"] }
      /// Information about an owner if available. This property is OCPI-compliant.
      public var owner: Owner? { __data["owner"] }

      /// StationList.Owner
      ///
      /// Parent Type: `Operator`
      public struct Owner: ChargeTripAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ChargeTripAPI.Objects.Operator }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        /// Name of an operator. This property is OCPI-compliant.
        public var name: String? { __data["name"] }
      }
    }
  }
}
