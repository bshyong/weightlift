require "spec_helper"

describe LiftsController do
  describe "routing" do

    it "routes to #index" do
      get("/lifts").should route_to("lifts#index")
    end

    it "routes to #new" do
      get("/lifts/new").should route_to("lifts#new")
    end

    it "routes to #show" do
      get("/lifts/1").should route_to("lifts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lifts/1/edit").should route_to("lifts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lifts").should route_to("lifts#create")
    end

    it "routes to #update" do
      put("/lifts/1").should route_to("lifts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lifts/1").should route_to("lifts#destroy", :id => "1")
    end

  end
end
