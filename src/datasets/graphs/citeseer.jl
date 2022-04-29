function __init__citeseer()
    DEPNAME = "CiteSeer"
    LINK = "https://github.com/kimiyoung/planetoid/raw/master/data"
    DOCS = "https://github.com/kimiyoung/planetoid"
    DATA = "ind.citeseer." .* ["x", "y", "tx", "allx", "ty", "ally", "graph", "test.index"]

    register(DataDep(
        DEPNAME,
        """
        Dataset: The $DEPNAME dataset.
        Website: $DOCS
        """,
        map(x -> "$LINK/$x", DATA),
        "7f7ec4df97215c573eee316de35754d89382011dfd9fb2b954a4a491057e3eb3",  # if checksum omitted, will be generated by DataDeps
        # post_fetch_method = unpack
    ))
end

"""
    CiteSeer(; dir=nothing)

The CiteSeer citation network dataset from Ref. [1].
Nodes represent documents and edges represent citation links.
The dataset is designed for the node classification task. 
The task is to predict the category of certain paper.
The dataset is retrieved from Ref. [2].

# References

[1]: [Deep Gaussian Embedding of Graphs: Unsupervised Inductive Learning via Ranking](https://arxiv.org/abs/1707.03815)
[2]: [Planetoid](https://github.com/kimiyoung/planetoid)
"""
struct CiteSeer <: AbstractDataset
    metadata::Dict{String, Any}
    graphs::Vector{Graph}
end

function CiteSeer(; dir=nothing, reverse_edges=true)
    metadata, g = read_planetoid_data("CiteSeer", dir=dir, reverse_edges=reverse_edges)
    return CiteSeer(metadata, [g])
end

Base.length(d::CiteSeer) = length(d.graphs) 
Base.getindex(d::CiteSeer) = d.graphs
Base.getindex(d::CiteSeer, i) = getindex(d.graphs, i)


