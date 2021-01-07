# frozen_string_literal: true

module Decidim
  module ActionDelegator
    class DelegatesVotes < Rectify::Query
      def initialize(authors_ids_votes = nil)
        @authors_ids_votes = authors_ids_votes
      end

      def query
        Decidim::User
          .joins("INNER JOIN decidim_action_delegator_delegations
                    ON decidim_users.id = decidim_action_delegator_delegations.granter_id
                  INNER JOIN decidim_consultations_votes
                    ON decidim_consultations_votes.decidim_author_id = decidim_action_delegator_delegations.granter_id")
          .where(decidim_action_delegator_delegations: { granter_id: authors_ids_votes })
      end

      private

      attr_reader :authors_ids_votes, :relation
    end
  end
end