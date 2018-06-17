module Drugs
  module V1

    class Drug_present < Grape::Entity
      expose :id_drug
      expose :issuing
      expose :registered_name
      expose :active_ingredient
      expose :pharmaceutical_form
      expose :insurance_list
      expose :atc
      expose :license_holder
     end

    class Drugs < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :drugs do

        params do
          requires :user_type, type: String
          
          # secondary filter insurance_list, in request split params with +
          optional :insurance_list, 
                    type: Array[String], 
                    allow_blank: false, 
                    coerce_with: ->(val) { val.split(/\s+/).map(&:to_s) }
         end
        
        desc 'Return a list of drugs by user_type'
          get do
          case params[:user_type]
            
          when "Student", "Other"
            puts params[:insurance_list]
            if params[:insurance_list].to_s.strip.empty?
              present Drug.where(issuing: "BR"), with: Drug_present
            else
              # secondary filter
              present Drug.where(issuing: "BR", insurance_list: params[:insurance_list]), with: Drug_present
             
            end

          when "MD"
            if params[:insurance_list].to_s.strip.empty?
              present Drug.where.not(issuing: "BR"), with: Drug_present
            else
              # secondary filter
              present Drug.where.not(issuing: "BR").where(insurance_list: params[:insurance_list]), with: Drug_present
            end

            else
              error!({ error: 'user_type does not exists' }, 404)
          end
          end
          
      end
    end
  end
end