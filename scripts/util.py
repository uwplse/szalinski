import sys
import gzip
import json

def open_json_gzip(path):
    print("Loading {}...".format(path), file=sys.stderr)
    with gzip.open(path) as f:
        return json.load(f)

def rules_time(j):
    return sum(
        it['search_time'] + it['apply_time'] + it['rebuild_time']
        for it in j['iterations']
    )

def load_json(path):
    print("Loading {}...".format(path), file=sys.stderr)
    j = json.load(open(path))
    iters = j['iterations']
    j['name'] = path
    j['rules_time'] = path
    j['set'] = path.split('/')[1]
    j['rules_time'] = rules_time(j)
    j['improvement'] = j['final_cost'] / j['initial_cost']
    j['iters'] = len(iters)
    j['nodes'] = iters[-1]['egraph_nodes']
    j['classes'] = iters[-1]['egraph_classes']

    # get the difference json
    base, ext = path[:-4], path[-4:]
    assert ext == 'json'
    try:
        diff_file = json.load(open(base + 'diff'))
    except FileNotFoundError:
        print("WARNING: can't open {}".format(base + 'diff'))
        return j

    j.update(diff_file)

    return j
