# Formula 1 Database Project: Basic DDL, DML, and DQL Using MySQL

In the fast-paced realm of Formula 1, a reliable database is essential for streamlined operations. Serving as a centralized hub, it houses critical data like race history, car metrics, and driver stats. This information fuels real-time decision-making during races, enabling engineers to adjust strategies on the fly based on telemetry data. Beyond the track, teams use the database for long-term planning, analyzing trends, and refining strategies over multiple seasons. Moreover, the database plays a pivotal role in technological advancements, facilitating simulations and predictive modeling to fine-tune car setups before races. In essence, the Formula 1 database is the linchpin of the entire system, supporting both immediate race decisions and long-term performance optimization.

## Database Design

### Entities

- **Engineer:** Represents personnel involved in fabricating car parts. Attributes include ID, name, address, date of birth (DOB), nationality, job, and profession.
  
- **Mechanic:** Personnel responsible for repairing racing cars. Attributes include ID, name, address, DOB, nationality, and level of expertise.
  
- **Car Parts:** Describes the various components of a Formula 1 car. Attributes include parts ID, version, type, and health status.
  
- **Car:** Represents Formula 1 cars. Attributes include car ID, version, and year.
  
- **Standings:** Tracks driver standings in races. Attributes include standings ID, race ID, driver ID, points, and race result.
  
- **Race Engineer:** Personnel responsible for communication and technical support during races. Attributes include ID, driver ID, name, address, DOB, nationality, and job.
  
- **Driver:** Represents Formula 1 drivers. Attributes include ID, team ID, car ID, name, address, DOB, nationality, contract dates, and position.
  
- **Team:** Represents racing teams. Attributes include team ID, team name, team principal ID, headquarters, engine supplier, main sponsor, and total points.
  
- **Team Principal:** Leaders of racing teams. Attributes include team principal ID, car ID, name, address, DOB, nationality, contract dates.
  
- **Sponsor:** Entities sponsoring Formula 1 teams. Attributes include sponsor ID, sponsor name, contract dates, and investment amount.
  
- **Race:** Describes Formula 1 races. Attributes include race ID, date, weather, race name, circuit name, region, city, and country.
  
- **Accident:** Records accidents involving Formula 1 cars. Attributes include car ID, accident ID, and date.
  
- **Department:** Represents functional units within a racing team. Attributes include building number, team ID, type, budget, and number of employees.
  
- **Pit Stops:** Records pit stop details during races. Attributes include race ID, time, duration, types of old and new tires.

### Relations

- **Works-IN:** Relates engineers to their respective departments. (Building number, Engineer ID)
  
- **Participates:** Links races to the cars participating. (Race ID, Car ID)
  
- **Sponsors:** Connects sponsors to the cars they sponsor. (Sponsor ID, Car ID)
  
- **Fixes:** Associates mechanics with the cars they repair. (Mechanic ID, Car ID)
  
- **Damages:** Tracks damage to car parts in accidents. (Parts ID, Car ID, Accident ID)
  
- **Fabricates:** Maps engineers to the car parts they fabricate. (Parts ID, Engineer ID, Building number)
  
- **Monitors:** Relates races to the cars being monitored. (Race ID, Car ID)
