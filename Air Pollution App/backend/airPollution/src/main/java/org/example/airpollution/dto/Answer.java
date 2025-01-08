package org.example.airpollution.dto;

import lombok.*;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Builder
public class Answer {

    private String cityName;
    private List<Results> results;

}
