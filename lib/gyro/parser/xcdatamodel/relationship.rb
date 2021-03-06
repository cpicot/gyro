# Copyright 2016 - Niji
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

module Gyro
  module Parser
    module XCDataModel
      # One Relationship between attributes in the xcdatamodel
      #
      class Relationship
        attr_accessor :entity_name, :name, :type, :optional, :deletion_rule, :comment
        attr_accessor :inverse_name, :inverse_type, :json_key_path, :support_annotation, :json_ignored
        attr_accessor :realm_ignored
        attr_accessor :destination

        alias realm_ignored? realm_ignored
        alias json_ignored? json_ignored

        # rubocop:disable Metrics/AbcSize
        def initialize(relationship_xml, entity_name)
          @entity_name = entity_name
          @name = relationship_xml.attributes['name'].to_s
          @optional = relationship_xml.attributes['optional'].to_s == 'YES'
          @deletion_rule = relationship_xml.attributes['deletionRule'].to_s
          @inverse_name = relationship_xml.attributes['inverseName'].to_s
          @inverse_type = relationship_xml.attributes['destinationEntity'].to_s
          @json_key_path = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'JSONKeyPath')
          @realm_ignored = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'realmIgnored').empty? ? false : true
          @json_ignored = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'JSONIgnored').empty? ? false : true
          @support_annotation = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'supportAnnotation')
          @comment = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'comment')
          load_type(relationship_xml)
          @destination = Gyro::Parser::XCDataModel.user_info(relationship_xml, 'destination')
          search_for_error
        end

        def to_h
          { 'entity_name' => entity_name, 'name' => name, 'type' => type.to_s,
            'optional' => optional, 'deletion_rule' => deletion_rule, 'comment' => comment,
            'inverse_name' => inverse_name, 'inverse_type' => inverse_type,
            'json_key_path' => json_key_path, 'json_ignored' => json_ignored,
            'support_annotation' => support_annotation,
            'realm_ignored' => realm_ignored, 'destination' => destination, 'inverse' => inverse? }
        end
        # rubocop:enable Metrics/AbcSize

        def to_s
          "\tRelationship => name=#{@name} | type=#{@type} | optional=#{@optional} | deletion_rule=#{@deletion_rule}\n"
        end

        def inverse?
          @name.end_with?('_')
        end

        private ################################################################

        def load_type(relationship_xml)
          max_count = relationship_xml.attributes['maxCount'].to_s
          @type = !max_count.nil? && (max_count == '1') ? :to_one : :to_many
        end

        def search_for_error
          # rubocop:disable Style/GuardClause
          if inverse_type.empty? && destination.empty?
            message = %(The relationship "#{@name}" from "#{@entity_name}" is wrong - please fix it)
            Gyro::Log.fail!(message)
          end
          if !destination.empty? && type != :to_many
            message = %(The relationship "#{@name}" from "#{@entity_name}" is wrong - ) +
                      %(please set a 'No Value' relationship as 'To Many')
            Gyro::Log.fail!(message)
          end
          # rubocop:enable Style/GuardClause
        end
      end
    end
  end
end
