class BSKStack:
    """
    Бело-Сине-Красный стек:
    White zone  – новые элементы
    Blue zone   – зрелые элементы
    Red zone    – старые, защищённые элементы
    """

    def __init__(self, white_ratio=0.3, blue_ratio=0.4):
        self.data = []
        self.white_ratio = white_ratio
        self.blue_ratio = blue_ratio

    # ----------------------------
    # Внутренние зоны
    # ----------------------------
    def _zones(self):
        n = len(self.data)
        w = int(n * self.white_ratio)
        b = int(n * (self.white_ratio + self.blue_ratio))
        return w, b  # границы: [0:w]=W, [w:b]=B, [b:n]=R

    # ----------------------------
    # Публичные операции
    # ----------------------------
    def push(self, item):
        self.data.insert(0, ("W", item))

    def pop(self):
        if not self.data:
            raise IndexError("BSKStack is empty")

        w, b = self._zones()

        # белая зона
        for i in range(0, w):
            if self.data[i][0] in ("W", "B"):
                return self.data.pop(i)[1]

        # синяя зона
        for i in range(w, b):
            if self.data[i][0] == "B":
                return self.data.pop(i)[1]

        # красная зона — запрещена
        raise PermissionError("Red zone is locked — cannot pop older elements")

    def update_colors(self):
        w, b = self._zones()
        for i, (_, item) in enumerate(self.data):
            if i < w:
                self.data[i] = ("W", item)
            elif i < b:
                self.data[i] = ("B", item)
            else:
                self.data[i] = ("R", item)

    def __len__(self):
        return len(self.data)

    def __repr__(self):
        return str(self.data)
