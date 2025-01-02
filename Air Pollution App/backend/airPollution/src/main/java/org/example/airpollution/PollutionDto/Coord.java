package org.example.airpollution.PollutionDto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
public class Coord {
    private double lon;
    private double lat;
}
