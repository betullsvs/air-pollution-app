package org.example.airpollution.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostDto
{
    private Long id;
    private Long userId;
    private String title;
    private String body;
}
