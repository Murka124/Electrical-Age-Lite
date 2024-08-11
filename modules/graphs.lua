local graphs = {}
function graphs.new(id)
    local graph = {}
    graph.structure = {id = id, verticies = {}}
    graph.example = {id = 0, verticies = {{id = 1, connections = {2}}, {id = 2, connections = {1, 3, 4, 5}}, {id = 3, connections = {2, 4}}, {id = 4, connections = {2, 3, 5}}, {id = 5, connections = {2, 4, 6}}, {id = 6, connections = {5}}}}

    return graph
end