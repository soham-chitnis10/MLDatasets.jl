function __init__cora()
    DEPNAME = "Cora"
    # LINK = "https://github.com/shchur/gnn-benchmark/raw/master/data/npz"
    # LINK = "https://github.com/abojchevski/graph2gauss/raw/master/data/"
    LINK = "https://github.com/kimiyoung/planetoid/raw/master/data"
    DOCS = "https://github.com/kimiyoung/planetoid"
    DATA = "ind.cora." .* ["x", "y", "tx", "allx", "ty", "ally", "graph", "test.index"]

    register(DataDep(
        DEPNAME,
        """
        Dataset: The $DEPNAME dataset.
        Website: $DOCS
        """,
        map(x -> "$LINK/$x", DATA),
        "81de017067dc045ebdb8ffd5c0e69a209973ffdb1fe2d5b434e94d3614f3f5c7",  # if checksum omitted, will be generated by DataDeps
        # post_fetch_method = unpack
    ))
end


"""
    Cora()

The Cora citation network dataset from Ref. [1].
Nodes represent documents and edges represent citation links.
Each node has a predefined feature with 1433 dimensions. 
The dataset is designed for the node classification task. 
The task is to predict the category of certain paper.
The dataset is retrieved from Ref. [2].

# Statistics 

- Nodes: 2708
- Edges: 10556
- Number of Classes: 7
- Label split:
    - Train:  140
    - Val:    500
    - Test:  1000

The split is the one used in the original paper [1] and 
doesn't consider all nodes.


# References

[1]: [Deep Gaussian Embedding of Graphs: Unsupervised Inductive Learning via Ranking](https://arxiv.org/abs/1707.03815)
[2]: [Planetoid](https://github.com/kimiyoung/planetoid
"""
struct Cora <: AbstractDataset
    metadata::Dict{String, Any}
    graphs::Vector{Graph}
end

function Cora(; dir=nothing, reverse_edges=true)
    metadata, g = read_planetoid_data("Cora", dir=dir, reverse_edges=reverse_edges)
    return Cora(metadata, [g])
end

Base.length(d::Cora) = length(d.graphs) 
Base.getindex(d::Cora) = d.graphs
Base.getindex(d::Cora, i) = getindex(d.graphs, i)
