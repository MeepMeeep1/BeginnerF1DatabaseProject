# Formula 1 Database Project


Basic DDL, DML, DQL

In the fast-paced realm of Formula 1, a reliable database is essential for streamlined operations. Serving as a centralized hub, it houses critical data like race history, car metrics, and driver stats. This information fuels real-time decision-making during races, enabling engineers to adjust strategies on the fly based on telemetry data. Beyond the track, teams use the database for long-term planning, analyzing trends and refining strategies over multiple seasons. Moreover, the database plays a pivotal role in technological advancements, facilitating simulations and predictive modeling to fine-tune car setups before races. In essence, the Formula 1 database is the linchpin of the entire system, supporting both immediate race decisions and long-term performance optimization.

The database should include entities for different personnel within the racing team, such as drivers, team principals, mechanics, and engineers. Key attributes to be recorded for all individuals are their respective ID’s(ID), name, address, date of birth (DOB), and nationality. Each specific role also has unique attributes. For example, drivers have a driver ID, contract start and end dates, and their position within the team, where each driver drives a car and has a specific team. Each Race engineer communicates with his driver during the race and has a specific job and ID, while each engineer fabricates car parts for his car and works in a department where each one has their profession and ID. Mechanics are responsible for fixing cars and are possessed with an ID and a specific level of experience. Team principles are responsible for the team as a whole.

Team principals represent the team's leaders and managers, their responsibilities extend beyond just managing the on-track performance and involve a combination of strategic, managerial, and leadership duties with attributes such as ID, contract start and end dates. They manage the team as a whole unit and oversee the team's ID, name, and headquarters. Each team principal is linked to the cars they manage.

Each race has attributes such as race ID, race name, circuit name, location, date, and weather conditions. In formula 1, drivers earn points based on their finishing positions in every race where drivers and teams experience shifts in position due to every result recorded. Thus standing include attributes such as points, position in the table, race results, and previous results, associated with team IDs. Each team has its standings related to the racing teams they are part of.

The database should also include departments representing various functional units within the team, each department has specialized functions and responsibilities, contributing to the overall performance of the team. They contain attributes such as department ID, type, budget, and the number of employees in each department. Engineers analyze and interpret information to identify areas for improvement and understand the car's behavior under different conditions. Their role is to fabricate different car parts specifying their ID, version, type (e.g., engine, chassis, front wing, floor, side pods), and health status. Car parts can get damaged in accidents and are assigned a unique accident ID. Mechanics play a pivotal role in ensuring the race cars are finely tuned, reliable, and ready for the intense demands of racing are mainly responsible for repairing the racing cars, identified by their ID and level of expertise.



During races, the driver is solely responsible for piloting their assigned car. They must navigate the track, make split-second decisions, and compete against other drivers to achieve the best possible result for themselves and the team. Each car includes attributes like car ID, car number, car name, and the year. Sponsors are linked to specific cars and have attributes like sponsor ID, sponsor name, contract start and end dates, and investment amounts. Race engineers serve as the primary point of contact between the driver and the technical team, playing a pivotal role in strategizing, decision-making, and ensuring that the car performs at its best on the track. They are identified by name and ID.

Pit stops are a dynamic and integral aspect of Formula 1 races, serving as a strategic and technical interlude where teams can enhance their competitive position through quick and efficient adjustments to the car, the art of pit stops combines speed, precision, and strategic decision-making to contribute significantly to a team's overall race performance. Pit stops include attributes such as duration, workers, time and tires including new and old tires. 



**Relational Model:**

  -Entities:
  
    ●	Engineer ( ID ,  name , address , dob , nationality, job, profession) 
    
    ●	Mechanic ( ID ,  name , address , dob , nationality , level)
    
    ●	Car parts ( parts-ID , version , type , health) 
    
    ●	Car( car-ID , CarVersion , year)
    
    ●	Standings(standings-ID, #race_ID, #driver_ID,points , raceResult)
    
    ●	Race Engineer( ID ,#Driver-ID(not null) ,   name , address , dob , nationality, job)
    
    ●	Driver(ID ,#team-ID(not null) ,# car-ID ,  name , address , dob , nationality , contract-End , Contract-start , position)
    
    ●	Team ( Team-ID ,Team_Name,# Team-principal-ID (not null),headquarters , Engine-supplier , main-sponsor, total_Points)
    
    ●	Team Principal(Team-Principal-ID , #carID , name , address , dob , nationality , contract-end , contract-start )
    
    ●	Sponsor(Sponsor_ID, sponsorName , contract_Start, investmentAmount, Contract_End)
    
    ●	Race(raceID, date, weather, raceName, circuitName, Region, City, Country)
    
    ●	Accident( #carID, Accident_ID, date)
    
    ●	Department(building-number , #teamID(not null) , type , budget , nbOfEmployees)
    
    ●	PitStops(#raceID , time, duration, type_of_old,  type_of_new)

  -Relations:
  
      ●	Works-IN ( #Building-number , #Engineer-ID) 
      
      ●	Participates(#raceID, #carID)
      
      ●	sponsors(#Sponsor_ID, #carID)
      
      ●	fixes(#Mechanic-ID, #carID)
      
      ●	damages(#parts-ID, #carID, #Accident_ID)
      
      ●	fabricates(#parts-ID,#Engineer-ID,  #building-number)
      
      ●	monitors(#race-ID , car-ID)
