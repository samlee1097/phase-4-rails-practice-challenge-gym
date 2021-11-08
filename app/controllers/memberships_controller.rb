class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    wrap_parameters false

    def index 
        memberships = Membership.all 
        render json: memberships
    end

    def show 
        membership = find_membership 
        render json: membership 
    end


    def create 
        membership = Membership.create!(membership_params)
        render json: membership, status: :created
    end

    private 
    def find_membership
        Membership.find(params[:id])
    end

    def membership_params
        params.permit(:charge, :gym_id, :client_id)
    end 

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def render_not_found_response(exception) render json: { error: "#{exception.model} not found" }, status: :not_found 
    end

end