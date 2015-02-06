 # Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gcloud/pubsub/errors"

module Gcloud
  module Pubsub
    ##
    # Represents a Pubsub Event.
    class Event
      ##
      # The Connection object.
      attr_accessor :connection #:nodoc:

      ##
      # The Google API Client object.
      attr_accessor :gapi #:nodoc:

      ##
      # Create an empty Subscription object.
      def initialize #:nodoc:
        @connection = nil
        @gapi = {}
      end

      ##
      # The acknowledgment ID for the message being acknowledged.
      # This was returned by the Pub/Sub system in the Pull response.
      # This ID must be used to acknowledge the received event.
      def ack_id
        @gapi["ackId"]
      end

      ##
      # The received message.
      def message
        @gapi["pubsubEvent"]["message"]["data"]
      end
      alias_method :msg, :message

      ##
      # The ID of this message, assigned by the server at publication time.
      # Guaranteed to be unique within the topic.
      def message_id
        @gapi["pubsubEvent"]["message"]["messageId"]
      end
      alias_method :msg_id, :message_id

      ##
      # New Topic from a Google API Client object.
      def self.from_gapi gapi, conn #:nodoc:
        new.tap do |f|
          f.gapi = gapi
          f.connection = conn
        end
      end
    end
  end
end
