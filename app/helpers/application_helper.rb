require 'rgl/traversal'
require 'rgl/adjacency'
require 'rgl/dijkstra'

module ApplicationHelper
   extend self

  def find_distance_between(origin, destination)
    adj_vertex = find_complete_list_of_vertex(origin, destination)
    return nil if adj_vertex.nil?

    complete_list = DistancePoint.where("origin in (#{adj_vertex}) and destination in (#{adj_vertex})")
    weights  = {}
    graph = RGL::DirectedAdjacencyGraph.new

    complete_list.each do |distance_point| 
      weights[[distance_point.origin,distance_point.destination]] = distance_point.distance 
      graph.add_vertices(distance_point.origin) unless graph.vertices.include?(distance_point.origin)
      graph.add_vertices(distance_point.destination) unless graph.vertices.include?(distance_point.destination)
      graph.add_edge(distance_point.origin, distance_point.destination)
    end

    calculate_weight(graph.dijkstra_shortest_path(weights, origin, destination), weights)
  end

  def find_complete_list_of_vertex(origin, destination)
    location_list = DistancePoint.where("destination = '#{destination}' or origin = '#{origin}'")

    list_of_vertex = (location_list.map(&:destination) + location_list.map(&:origin)).uniq.map{|i| "'#{i}'"}.join(",")
    return nil unless list_of_vertex.include?(origin) && list_of_vertex.include?(destination)
    list_of_vertex
  end

  def calculate_weight(shortest_path, weights)
    paths = shortest_path.map.with_index {|vtx,idx| [vtx,shortest_path[idx+1]] unless shortest_path[idx+1].nil? }.compact
    paths.map {|vtx| weights[vtx] }.inject(&:+)
  end
end
