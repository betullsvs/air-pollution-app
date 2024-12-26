package org.example.airpollution.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Builder
public class Compound {

    private String name;
    private String pollutionType;
}
