package org.ipcat;

import java.util.ArrayList;
import java.util.List;

public class Blocks {
    private List<Integer> starts;
    private List<Integer> ends;

    public Blocks() {
        this.starts = new ArrayList<Integer>();
        this.ends = new ArrayList<Integer>();
    }

    public void add(Integer start, Integer end) {
        this.starts.add(start);
        this.ends.add(end);
    }

    public int find(Integer value) {
        int high = this.starts.size() -1;
        int low = 0;
        int probe;
        while(high >= low) {
            probe = (high + low) / 2;
            if ( this.starts.get(probe) > value) {
                high = probe - 1;
            } else {
                if ( this.ends.get(probe) < value) {
                    low = probe +1;
                } else {
                    return probe;
                }
            }
        }
        return -1;
    }

}
