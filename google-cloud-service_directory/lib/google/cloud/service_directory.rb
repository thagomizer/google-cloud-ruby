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

# Require this file early so that the version constant gets defined before
# requiring "google/cloud". This is because google-cloud-core will load the
# entrypoint (gem name) file, which in turn re-requires this file (hence
# causing a require cycle) unless the version constant is already defined.
require "google/cloud/service_directory/version"

require "googleauth"
gem "google-cloud-core"
require "google/cloud" unless defined? ::Google::Cloud.new
require "google/cloud/config"

# Set the default configuration
::Google::Cloud.configure.add_config! :service_directory do |config|
  config.add_field! :credentials,  nil, match: [::String, ::Hash, ::Google::Auth::Credentials]
  config.add_field! :lib_name,     nil, match: ::String
  config.add_field! :lib_version,  nil, match: ::String
  config.add_field! :interceptors, nil, match: ::Array
  config.add_field! :timeout,      nil, match: ::Numeric
  config.add_field! :metadata,     nil, match: ::Hash
  config.add_field! :retry_policy, nil, match: [::Hash, ::Proc]
end

module Google
  module Cloud
    module ServiceDirectory
      ##
      # Create a new client object for LookupService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::ServiceDirectory::V1beta1::LookupService::Client](https://googleapis.dev/ruby/google-cloud-service_directory-v1beta1/latest/Google/Cloud/ServiceDirectory/V1beta1/LookupService/Client.html)
      # for version V1beta1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the LookupService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About LookupService
      #
      # Service Directory API for looking up service data at runtime.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1beta1`.
      # @return [LookupService::Client] A client object for the specified version.
      #
      def self.lookup_service version: :v1beta1, &block
        require "google/cloud/service_directory/#{version.to_s.downcase}"

        package_name = Google::Cloud::ServiceDirectory
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::ServiceDirectory.const_get package_name
        package_module.const_get(:LookupService).const_get(:Client).new(&block)
      end

      ##
      # Create a new client object for RegistrationService.
      #
      # By default, this returns an instance of
      # [Google::Cloud::ServiceDirectory::V1beta1::RegistrationService::Client](https://googleapis.dev/ruby/google-cloud-service_directory-v1beta1/latest/Google/Cloud/ServiceDirectory/V1beta1/RegistrationService/Client.html)
      # for version V1beta1 of the API.
      # However, you can specify specify a different API version by passing it in the
      # `version` parameter. If the RegistrationService service is
      # supported by that API version, and the corresponding gem is available, the
      # appropriate versioned client will be returned.
      #
      # ## About RegistrationService
      #
      # Service Directory API for registering services. It defines the following
      # resource model:
      #
      # - The API has a collection of
      # Namespace
      # resources, named `projects/*/locations/*/namespaces/*`.
      #
      # - Each Namespace has a collection of
      # Service resources, named
      # `projects/*/locations/*/namespaces/*/services/*`.
      #
      # - Each Service has a collection of
      # Endpoint
      # resources, named
      # `projects/*/locations/*/namespaces/*/services/*/endpoints/*`.
      #
      # @param version [::String, ::Symbol] The API version to connect to. Optional.
      #   Defaults to `:v1beta1`.
      # @return [RegistrationService::Client] A client object for the specified version.
      #
      def self.registration_service version: :v1beta1, &block
        require "google/cloud/service_directory/#{version.to_s.downcase}"

        package_name = Google::Cloud::ServiceDirectory
                       .constants
                       .select { |sym| sym.to_s.downcase == version.to_s.downcase.tr("_", "") }
                       .first
        package_module = Google::Cloud::ServiceDirectory.const_get package_name
        package_module.const_get(:RegistrationService).const_get(:Client).new(&block)
      end

      ##
      # Configure the google-cloud-service_directory library.
      #
      # The following configuration parameters are supported:
      #
      # * `credentials` (*type:* `String, Hash, Google::Auth::Credentials`) -
      #   The path to the keyfile as a String, the contents of the keyfile as a
      #   Hash, or a Google::Auth::Credentials object.
      # * `lib_name` (*type:* `String`) -
      #   The library name as recorded in instrumentation and logging.
      # * `lib_version` (*type:* `String`) -
      #   The library version as recorded in instrumentation and logging.
      # * `interceptors` (*type:* `Array<GRPC::ClientInterceptor>`) -
      #   An array of interceptors that are run before calls are executed.
      # * `timeout` (*type:* `Integer`) -
      #   Default timeout in milliseconds.
      # * `metadata` (*type:* `Hash{Symbol=>String}`) -
      #   Additional gRPC headers to be sent with the call.
      # * `retry_policy` (*type:* `Hash`) -
      #   The retry policy. The value is a hash with the following keys:
      #     * `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
      #     * `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
      #     * `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
      #     * `:retry_codes` (*type:* `Array<String>`) -
      #       The error codes that should trigger a retry.
      #
      # @return [::Google::Cloud::Config] The default configuration used by this library
      #
      def self.configure
        yield ::Google::Cloud.configure.service_directory if block_given?

        ::Google::Cloud.configure.service_directory
      end
    end
  end
end
