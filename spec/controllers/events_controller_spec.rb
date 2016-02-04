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
        end
    end

    describe "#load_more" do
        before(:all) do
        end

        it "load more" do
            # /events/load_more?last_id=11&team_id=1
            get :load_more, team_id:1, last_id:11
            expect(response).to have_http_status(200)
        end

        #it "load more no last id" do
            # http://localhost:3000/events/load_more?last_id=11&team_id=1
        #end

        #it "load after last page" do
            # http://localhost:3000/events/load_more?last_id=1&team_id=1
        #end

        #it "load no team"

        #end

        #it "load wrong params" do

        #end
    end
end
