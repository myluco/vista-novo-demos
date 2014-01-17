Blood Pressure Demo Application for VistA Novo
==============================================

This application demonstrates the functionality of VistA Novo through a very simple blood pressure use case.

Installation and Setup
----------------------

Once you have installed the VistA Novo test stub, you will need to install the gems for the demo application.
To do that navigate to the top level of the demo/blood_pressure directory and enter the following commands:

    rvm use 1.9.3
    bundle install

VistA Novo, the Test Stub, and the demo application all need to be running on different ports.  If you have 
VistA Novo running at port 3000 (the default) and the Test Stub at port 3001, you can start the demo 
application:

	bundle exec rails s

For more information on how the demo application handles URLs, run:

    rake routes
    