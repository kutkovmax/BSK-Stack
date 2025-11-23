import java.util.ArrayList;
import java.util.List;

public class BSKStack<T> {

    private static class Node<T> {
        String color;
        T value;
        Node(String c, T v) { color = c; value = v; }
    }

    private final List<Node<T>> data = new ArrayList<>();
    private final double whiteRatio;
    private final double blueRatio;

    public BSKStack(double whiteRatio, double blueRatio) {
        this.whiteRatio = whiteRatio;
        this.blueRatio = blueRatio;
    }

    public BSKStack() {
        this(0.3, 0.4);
    }

    private int[] zones() {
        int n = data.size();
        int w = (int)(n * whiteRatio);
        int b = (int)(n * (whiteRatio + blueRatio));
        return new int[] { w, b };
    }

    public void push(T item) {
        data.add(0, new Node<>("W", item));
    }

    public T pop() {
        if (data.isEmpty())
            throw new IllegalStateException("Empty BSKStack");

        int[] z = zones();
        int w = z[0], b = z[1];

        // White zone
        for (int i = 0; i < w; i++) {
            if (data.get(i).color.equals("W") || data.get(i).color.equals("B")) {
                return data.remove(i).value;
            }
        }

        // Blue zone
        for (int i = w; i < b; i++) {
            if (data.get(i).color.equals("B")) {
                return data.remove(i).value;
            }
        }

        throw new RuntimeException("Red zone is locked");
    }

    public void updateColors() {
        int[] z = zones();
        int w = z[0], b = z[1];

        for (int i = 0; i < data.size(); i++) {
            Node<T> n = data.get(i);
            if (i < w) n.color = "W";
            else if (i < b) n.color = "B";
            else n.color = "R";
        }
    }

    public int size() { return data.size(); }

    @Override
    public String toString() {
        return data.toString();
    }
}
