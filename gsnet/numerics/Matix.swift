struct Matix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows; self.columns = columns

        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }

    func AreValid(row: Int, _ column: Int) -> Bool {
        return IsValid(row, rows) && IsValid(column, columns)
    }

    private func IsValid(value: Int, _ axis: Int) -> Bool {
        return value >= 0 && value < axis
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(AreValid(row, column), "Index is out of Range")
            return grid[(row * columns) + column]
        } set(value) {
            assert(AreValid(row, column), "Index is out of Range")
            grid[(row * columns) + column] = value
        }
    }
}