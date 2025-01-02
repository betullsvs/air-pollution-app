package org.example.airpollution.service;

public class AssignCategories {

    public String calculateTypeOfCo(Float co) {

        if (co >0 && co <= 1.0)
        {
            return "Good";
        }
        else if (co >1.0 && co <= 2.0)
        {
            return "Satisfactory";
        }
        else if (co >2.0&& co <= 10.0)
        {
            return "Moderate";
        }
        else if (co >10.0 && co<=17.0)
        {
            return "Poor";
        }
        else if (co >17.0 && co<=34.0)
        {
            return "Very Poor";
        }
        else if (co >34.0)
        {
            return "Severe";
        }
        else
        {
            return "No Type";
        }

    }

    public String calculateTypeOfO3(Float O3) {
        if (O3 >0 && O3 <= 50.0)
        {
            return "Good";
        }
        else if (O3 >50.0 && O3 <= 100.0)
        {
            return "Satisfactory";
        }
        else if (O3 >100.0&& O3 <= 168.0)
        {
            return "Moderate";
        }
        else if (O3 >168.0 && O3<=208.0)
        {
            return "Poor";
        }
        else if (O3 >208.0 && O3<=748.0)
        {
            return "Very Poor";
        }
        else if (O3 >748.0)
        {
            return "Severe";
        }
        else
        {
            return "No Type";
        }
    }


    public String calculateTypeOfSo2(Float so2) {
        if (so2 >0 && so2 <= 40.0)
        {
            return "Good";
        }
        else if (so2 >40.0 && so2 <= 80.0)
        {
            return "Satisfactory";
        }
        else if (so2 >80.0&& so2 <= 380.0)
        {
            return "Moderate";
        }
        else if (so2 >380.0 && so2<=800.0)
        {
            return "Poor";
        }
        else if (so2 >800.0 && so2<=1600.0)
        {
            return "Very Poor";
        }
        else if (so2 >1600.0)
        {
            return "Severe";
        }
        else
        {
            return "No Type";
        }
    }
}
