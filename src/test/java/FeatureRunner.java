import com.intuit.karate.junit5.Karate;

class FeatureRunner {


    /**
     * https://www.testingexcellence.com/karate-api-testing-tool-cheat-sheet/
     *
     */


    @Karate.Test
    Karate testUsers() {
//     return new Karate().feature("bookit.feature").relativeTo(getClass());
       return new Karate().tags("bookit").relativeTo(getClass());
    }

    @Karate.Test
    Karate getSpartans(){
        return new Karate().tags("@spartan").relativeTo(getClass());
    }
}
