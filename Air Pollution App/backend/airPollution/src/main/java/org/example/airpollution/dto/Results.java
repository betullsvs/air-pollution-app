package org.example.airpollution.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Builder
public class Results {

    private LocalDate date;
    private List<Categories> categories;
}
