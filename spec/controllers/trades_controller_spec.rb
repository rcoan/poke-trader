require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe TradesController, type: :controller do
  describe '#create' do
    describe 'when all params are right' do
      it 'redirect to home with success message' do
        params = {
          trade: {
            sent_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 2,
                name: 'Monstro de bolso 2',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 3,
                name: 'Monstro de bolso 3',
                base_experience: 10,
                image_path: 'path'
              }

            ],
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }
            ]
          }
        }

        expect { post :create, params: params }
          .to change { Trade.all.size }.from(0).to(1)

        expect(response).to be_successful
        expect(response).to render_template('trades/index')
      end
    end

    describe 'when there is missing params' do
      it 'raise error' do
        params = {
          trade: {
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }
            ]
          }
        }

        expect { post :create, params: params }
          .to raise_error(ArgumentError)

        expect(response).to be_successful
      end
    end

    describe 'when the base experience deviation is too high' do
      it 'stays in new page with error message' do
        params = {
          trade: {
            sent_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 300,
                image_path: 'path'
              },
              {
                id: 2,
                name: 'Monstro de bolso 2',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 3,
                name: 'Monstro de bolso 3',
                base_experience: 10,
                image_path: 'path'
              }

            ],
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }
            ]
          }
        }

        expect { post :create, params: params }
          .to_not change { Trade.all.size }.from(0)
        expect(response).to be_successful
        expect(response).to render_template('trades/new')
      end
    end
  end
end