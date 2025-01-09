class Api::V1::CategoriesController < ApplicationController
    def index
        # Fetch all categories with their associated transactions
        categories_with_transactions = Category.includes(:transactions).map do | category | {
            category: {
            id: category.id,
            name: category.name,
            sub_category: category.sub_category,
            description: category.description
            },
            transactions: category.transactions.select(:id,:name,:amount,:authorized_date)
        }
        end
        
        render json: categories_with_transactions
    end
    
    def show
        # Find the category by ID
        category = Category.find(params[:id])
        
        # Include associated transactions
        render json: {
        category: {
            id: category.id,
            name: category.name,
            sub_category: category.sub_category,
            description: category.description,
            plaid_hierarchy: category.plaid_hierarchy
        },
        transactions: category.transactions.select(:id,:name,:amount,:authorized_date)
        }
        rescue ActiveRecord::RecordNotFound

        render json: {
            error: 'Category not found'
        }, status: not_found
    end
end