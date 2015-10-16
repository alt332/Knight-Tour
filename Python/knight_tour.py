import sys


def is_valid_point(point, size):
    x = isinstance(point[0], int) and point[0] >= 0 and point[0] < size
    y = isinstance(point[1], int) and point[1] >= 0 and point[1] < size
    return x and y


def get_neighbours(x, y, size):
    candidate = [[x+1, y-2], [x+1, y+2],
                 [x+2, y+1], [x+2, y-1],
                 [x-1, y-2], [x-1, y+2],
                 [x-2, y+1], [x-2, y-1]]
    return [c for c in candidate if is_valid_point(c, size)]


def get_next_move(point, size, moves):
    lengths = []
    get_neighbours(point[0], point[1], size)

    for n in get_neighbours(point[0], point[1], size):
        if n not in moves:
            lengths.append([len(get_neighbours(n[0], n[1], size)), n])

    if lengths:
        next_move = sorted(lengths)[0][1]
        return next_move[0], next_move[1]
    else:
        return None, None


def solve(x, y, size, moves=[]):
    moves.append([x, y])
    neighbours = get_neighbours(x, y, size)
    neighbours = [n for n in neighbours if n not in moves]
    next_x, next_y = get_next_move([x, y], size, moves)

    if neighbours and (next_x is not None and next_y is not None):
        return solve(next_x, next_y, size, moves)
    else:
        for m in reversed(moves):
            print m


solve(int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))
