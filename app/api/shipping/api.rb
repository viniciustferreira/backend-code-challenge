
class Shipping::API < Grape::API

  resource :distance do
    params do
      requires :origin, type: String, desc: 'origin'
      requires :destination, type: String, desc: 'destiny'
      requires :distance, type: Integer, desc: 'distance', values: 0..100000 
    end

    post '/' do
      distance_point = DistancePoint.find_by(origin: params[:origin], destination: params[:destination])
      distance_point.update(distance: params[:distance]) if distance_point

      distance_point = DistancePoint.create(params) if distance_point.nil?
      distance_point.id
    end
  end

  resource :cost do
    params do
      requires :origin, type: String, desc: 'origin '
      requires :destination, type: String, desc: 'destiny '
      requires :weight, type: Integer, desc: 'weight', values: 0..50
    end

    get '/' do
      distance = ApplicationHelper::find_distance_between(params[:origin], params[:destination]) 
      return nil if distance.nil?
      distance * params[:weight] * 0.15
    end
  end
end