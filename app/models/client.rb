class Client < ApplicationRecord
    has_many :memberships
    has_many :gyms, through: :memberships

    attribute :total_amount

    def total_amount
        self.memberships.sum(&:charge)
    end
end
