package org.example.airpollution.model;




import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PollutionRecord {


    private Long id;

    private Long cityId;

    private LocalDate date;

    private Float carbonMonoxide;

    private Float ozone;

    private Float sulphurDioxide;

    private String typeCo;

    private String typeO3;

    private String typeSo2;


   /* public List<Categorie> getPollutionCategories() {
        return List.of(
                Categorie.builder()
                        .compound(
                                Compound.builder()
                                        .name("CO:")
                                        .pollutionType(typeCo)
                                        .build()
                        )
                        .build(),
                Categorie.builder()
                        .compound(
                                Compound.builder()
                                        .name("SO2:")
                                        .pollutionType(typeSo2)
                                        .build()
                        )
                        .build(),
                Categorie.builder()
                        .compound(
                                Compound.builder()
                                        .name("O3:")
                                        .pollutionType(typeO3)
                                        .build()
                        )
                        .build()
        );
    }*/

}
