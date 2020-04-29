# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Cloud
    module Recommender
      module V1
        # A recommendation along with a suggested action. E.g., a rightsizing
        # recommendation for an underutilized VM, IAM role recommendations, etc
        # @!attribute [rw] name
        #   @return [::String]
        #     Name of recommendation.
        # @!attribute [rw] description
        #   @return [::String]
        #     Free-form human readable summary in English. The maximum length is 500
        #     characters.
        # @!attribute [rw] recommender_subtype
        #   @return [::String]
        #     Contains an identifier for a subtype of recommendations produced for the
        #     same recommender. Subtype is a function of content and impact, meaning a
        #     new subtype might be added when significant changes to `content` or
        #     `primary_impact.category` are introduced. See the Recommenders section
        #     to see a list of subtypes for a given Recommender.
        #
        #     Examples:
        #       For recommender = "google.iam.policy.Recommender",
        #       recommender_subtype can be one of "REMOVE_ROLE"/"REPLACE_ROLE"
        # @!attribute [rw] last_refresh_time
        #   @return [::Google::Protobuf::Timestamp]
        #     Last time this recommendation was refreshed by the system that created it
        #     in the first place.
        # @!attribute [rw] primary_impact
        #   @return [::Google::Cloud::Recommender::V1::Impact]
        #     The primary impact that this recommendation can have while trying to
        #     optimize for one category.
        # @!attribute [rw] additional_impact
        #   @return [::Array<::Google::Cloud::Recommender::V1::Impact>]
        #     Optional set of additional impact that this recommendation may have when
        #     trying to optimize for the primary category. These may be positive
        #     or negative.
        # @!attribute [rw] content
        #   @return [::Google::Cloud::Recommender::V1::RecommendationContent]
        #     Content of the recommendation describing recommended changes to resources.
        # @!attribute [rw] state_info
        #   @return [::Google::Cloud::Recommender::V1::RecommendationStateInfo]
        #     Information for state. Contains state and metadata.
        # @!attribute [rw] etag
        #   @return [::String]
        #     Fingerprint of the Recommendation. Provides optimistic locking when
        #     updating states.
        class Recommendation
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Contains what resources are changing and how they are changing.
        # @!attribute [rw] operation_groups
        #   @return [::Array<::Google::Cloud::Recommender::V1::OperationGroup>]
        #     Operations to one or more Google Cloud resources grouped in such a way
        #     that, all operations within one group are expected to be performed
        #     atomically and in an order.
        class RecommendationContent
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Group of operations that need to be performed atomically.
        # @!attribute [rw] operations
        #   @return [::Array<::Google::Cloud::Recommender::V1::Operation>]
        #     List of operations across one or more resources that belong to this group.
        #     Loosely based on RFC6902 and should be performed in the order they appear.
        class OperationGroup
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Contains an operation for a resource loosely based on the JSON-PATCH format
        # with support for:
        #
        # * Custom filters for describing partial array patch.
        # * Extended path values for describing nested arrays.
        # * Custom fields for describing the resource for which the operation is being
        #   described.
        # * Allows extension to custom operations not natively supported by RFC6902.
        # See https://tools.ietf.org/html/rfc6902 for details on the original RFC.
        # @!attribute [rw] action
        #   @return [::String]
        #     Type of this operation. Contains one of 'and', 'remove', 'replace', 'move',
        #     'copy', 'test' and custom operations. This field is case-insensitive and
        #     always populated.
        # @!attribute [rw] resource_type
        #   @return [::String]
        #     Type of GCP resource being modified/tested. This field is always populated.
        #     Example: cloudresourcemanager.googleapis.com/Project,
        #     compute.googleapis.com/Instance
        # @!attribute [rw] resource
        #   @return [::String]
        #     Contains the fully qualified resource name. This field is always populated.
        #     ex: //cloudresourcemanager.googleapis.com/projects/foo.
        # @!attribute [rw] path
        #   @return [::String]
        #     Path to the target field being operated on. If the operation is at the
        #     resource level, then path should be "/". This field is always populated.
        # @!attribute [rw] source_resource
        #   @return [::String]
        #     Can be set with action 'copy' to copy resource configuration across
        #     different resources of the same type. Example: A resource clone can be
        #     done via action = 'copy', path = "/", from = "/",
        #     source_resource = <source> and resource_name = <target>.
        #     This field is empty for all other values of `action`.
        # @!attribute [rw] source_path
        #   @return [::String]
        #     Can be set with action 'copy' or 'move' to indicate the source field within
        #     resource or source_resource, ignored if provided for other operation types.
        # @!attribute [rw] value
        #   @return [::Google::Protobuf::Value]
        #     Value for the `path` field. Will be set for actions:'add'/'replace'.
        #     Maybe set for action: 'test'. Either this or `value_matcher` will be set
        #     for 'test' operation. An exact match must be performed.
        # @!attribute [rw] value_matcher
        #   @return [::Google::Cloud::Recommender::V1::ValueMatcher]
        #     Can be set for action 'test' for advanced matching for the value of
        #     'path' field. Either this or `value` will be set for 'test' operation.
        # @!attribute [rw] path_filters
        #   @return [::Google::Protobuf::Map{::String => ::Google::Protobuf::Value}]
        #     Set of filters to apply if `path` refers to array elements or nested array
        #     elements in order to narrow down to a single unique element that is being
        #     tested/modified.
        #     This is intended to be an exact match per filter. To perform advanced
        #     matching, use path_value_matchers.
        #
        #     * Example: {
        #       "/versions/*/name" : "it-123"
        #       "/versions/*/targetSize/percent": 20
        #      }
        #     * Example: {
        #       "/bindings/*/role": "roles/admin"
        #       "/bindings/*/condition" : null
        #      }
        #     * Example: {
        #       "/bindings/*/role": "roles/admin"
        #       "/bindings/*/members/*" : ["x@google.com", "y@google.com"]
        #      }
        #     When both path_filters and path_value_matchers are set, an implicit AND
        #     must be performed.
        # @!attribute [rw] path_value_matchers
        #   @return [::Google::Protobuf::Map{::String => ::Google::Cloud::Recommender::V1::ValueMatcher}]
        #     Similar to path_filters, this contains set of filters to apply if `path`
        #     field referes to array elements. This is meant to support value matching
        #     beyond exact match. To perform exact match, use path_filters.
        #     When both path_filters and path_value_matchers are set, an implicit AND
        #     must be performed.
        class Operation
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::Google::Protobuf::Value]
          class PathFiltersEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::Google::Cloud::Recommender::V1::ValueMatcher]
          class PathValueMatchersEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end
        end

        # Contains various matching options for values for a GCP resource field.
        # @!attribute [rw] matches_pattern
        #   @return [::String]
        #     To be used for full regex matching. The regular expression is using the
        #     Google RE2 syntax (https://github.com/google/re2/wiki/Syntax), so to be
        #     used with RE2::FullMatch
        class ValueMatcher
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Contains metadata about how much money a recommendation can save or incur.
        # @!attribute [rw] cost
        #   @return [::Google::Type::Money]
        #     An approximate projection on amount saved or amount incurred. Negative cost
        #     units indicate cost savings and positive cost units indicate increase.
        #     See google.type.Money documentation for positive/negative units.
        # @!attribute [rw] duration
        #   @return [::Google::Protobuf::Duration]
        #     Duration for which this cost applies.
        class CostProjection
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods
        end

        # Contains the impact a recommendation can have for a given category.
        # @!attribute [rw] category
        #   @return [::Google::Cloud::Recommender::V1::Impact::Category]
        #     Category that is being targeted.
        # @!attribute [rw] cost_projection
        #   @return [::Google::Cloud::Recommender::V1::CostProjection]
        #     Use with CategoryType.COST
        class Impact
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # The category of the impact.
          module Category
            # Default unspecified category. Don't use directly.
            CATEGORY_UNSPECIFIED = 0

            # Indicates a potential increase or decrease in cost.
            COST = 1

            # Indicates a potential increase or decrease in security.
            SECURITY = 2

            # Indicates a potential increase or decrease in performance.
            PERFORMANCE = 3

            # Indicates a potential increase or decrease in manageability.
            MANAGEABILITY = 4
          end
        end

        # Information for state. Contains state and metadata.
        # @!attribute [rw] state
        #   @return [::Google::Cloud::Recommender::V1::RecommendationStateInfo::State]
        #     The state of the recommendation, Eg ACTIVE, SUCCEEDED, FAILED.
        # @!attribute [rw] state_metadata
        #   @return [::Google::Protobuf::Map{::String => ::String}]
        #     A map of metadata for the state, provided by user or automations systems.
        class RecommendationStateInfo
          include ::Google::Protobuf::MessageExts
          extend ::Google::Protobuf::MessageExts::ClassMethods

          # @!attribute [rw] key
          #   @return [::String]
          # @!attribute [rw] value
          #   @return [::String]
          class StateMetadataEntry
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # Represents Recommendation State
          module State
            # Default state. Don't use directly.
            STATE_UNSPECIFIED = 0

            # Recommendation is active and can be applied. Recommendations content can
            # be updated by Google.
            #
            # ACTIVE recommendations can be marked as CLAIMED, SUCCEEDED, or FAILED.
            ACTIVE = 1

            # Recommendation is in claimed state. Recommendations content is
            # immutable and cannot be updated by Google.
            #
            # CLAIMED recommendations can be marked as CLAIMED, SUCCEEDED, or FAILED.
            CLAIMED = 6

            # Recommendation is in succeeded state. Recommendations content is
            # immutable and cannot be updated by Google.
            #
            # SUCCEEDED recommendations can be marked as SUCCEEDED, or FAILED.
            SUCCEEDED = 3

            # Recommendation is in failed state. Recommendations content is immutable
            # and cannot be updated by Google.
            #
            # FAILED recommendations can be marked as SUCCEEDED, or FAILED.
            FAILED = 4

            # Recommendation is in dismissed state. Recommendation content can be
            # updated by Google.
            #
            # DISMISSED recommendations can be marked as ACTIVE.
            DISMISSED = 5
          end
        end
      end
    end
  end
end
