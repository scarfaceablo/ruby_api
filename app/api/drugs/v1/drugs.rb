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
          optional :sort_by, type: String
         end
        
        desc 'Return a list of drugs by user_type'
        #active_ingredient
          get do
            column_names = Drug.column_names
          case params[:user_type]
            when "Student","Other"

              unless params[:sort_by].to_s.strip.empty?
                unless column_names.include? params[:sort_by].to_s
                  error!({ error: 'sort_by does not exists' }, 404)
                else
                  present Drug.where(issuing: "BR").order("#{params[:sort_by]} ASC"), with: Drug_present
                end
              else
                present Drug.where(issuing: "BR"), with: Drug_present
              end

            when "MD"

              unless params[:sort_by].to_s.strip.empty?
                unless column_names.include? params[:sort_by].to_s
                  error!({ error: 'sort_by does not exists' }, 404)
                else
                  present Drug.where.not(issuing: "BR").order("#{params[:sort_by]} ASC"), with: Drug_present
                end
              else
                present Drug.where.not(issuing: "BR"), with: Drug_present
              end
            else
              error!({ error: 'user_type does not exists' }, 404)
          end
          end
          
      end
    end
  end
end