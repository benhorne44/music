Heckendorf::Application.routes.draw do
  root to: "landing#index"
  get 'instagram' => "landing#instagram"
end
