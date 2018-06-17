module Drugs
  class Base < Grape::API
   mount Drugs::V1::Drugs
  end
 end