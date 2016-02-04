require 'rails_helper'
RSpec.describe EventsController, type: :controller do
    fixtures :all

    before(:all) do
    end

    describe "#index" do
        before(:all) do
        end

        it "team events" do
            # /events/index?team_id=1
            get :index, team_id:1
            expect(response).to have_http_status(200)
            expect(response).to render_template(:index)
        end

        it "team events not found" do
            # /events/index?team_id=3
            get :index, team_id:3
            expect(response).to have_http_status(404)
        end

        it "no team" do
            # /events/index
            get :index
            expect(response).to have_http_status(404)
        end
    end

    describe "#load_more" do
        it "load more" do
            # /events/load_more?last_id=11&team_id=1
            get :load_more, team_id:1, last_id:11
            expect(response).to have_http_status(200)
        end

        it "load more arguments" do
            # http://localhost:3000/events/load_more?last_id=11&team_id=1
            get :load_more, team_id:1
            expect(response).to have_http_status(404)

            get :load_more
            expect(response).to have_http_status(404)
        end
    end
end
