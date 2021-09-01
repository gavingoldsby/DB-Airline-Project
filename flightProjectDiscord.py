import mysql.connector
import discord
import datetime
from discord.ext import commands
from mysql.connector import Error
from string import Template

bot = commands.Bot(command_prefix="$")

dbLink = mysql.connector.connect(
	host="localhost",
	user="root",
	passwd="whitman1",
	db="project"
)

if dbLink is not None:
	print ("Connection to SQL database successfully established")


class DeltaTemplate(Template):
    delimiter = "%"

def secondsToString(tdelta, fmt):
    d = {"D": tdelta.days}
    hours, rem = divmod(tdelta.seconds, 3600)
    minutes, seconds = divmod(rem, 60)
    d["H"] = '{:02d}'.format(hours)
    d["M"] = '{:02d}'.format(minutes)
    d["S"] = '{:02d}'.format(seconds)
    t = DeltaTemplate(fmt)
    return t.substitute(**d)


@bot.event
async def on_ready():
  print("Bot running with the following credentials:")
  print("Username:", bot.user.name)
  print("User ID:", bot.user.id)

@bot.command()
async def users(ctx):
	serverID = ctx.guild
	await ctx.send(f"""# of Members: {serverID.member_count}""")

@bot.command()
async def ping(ctx):
    await ctx.send("Pong!")

@bot.command()
async def echo(ctx, *, content:str):
    await ctx.send(content)
@bot.command()
async def userBooking(ctx, *args):
    cursor = dbLink.cursor()
    if len(args) != 1:
        await ctx.send("Not enough/too much user information was provided. Please try again.")

    query = "call outputCustomerBooking(\'" + str(args[0]) + "\')"
    cursor.execute(query)
    results = cursor.fetchall()

    outputString = ""
    if len(results) == 0:
        await ctx.send("There is no user that satisfies the provided input. Try something else.")
    for row in results:
        try:
            outputString.join(row)
        except TypeError:
            for item in row:
                if isinstance(item, datetime.date):
                    dateString = item.strftime('%m/%d/%Y')
                    outputString = outputString + dateString + " "
                elif isinstance(item, datetime.timedelta):
                    timeString = secondsToString(item, '%H:%M:%S') + " "
                    outputString = outputString + timeString
                else:
                    outputString = outputString + str(item) + " "
    print(outputString)
    await ctx.send(outputString)
@bot.command()
async def showAllFlights(ctx):
	cursor = dbLink.cursor()
	query = "select * from flight"
	cursor.execute(query)
	results = cursor.fetchall()
	outputString = ""
	for row in results:
		try:
			outputString.join(row)
		except TypeError:
			for item in row:
				if isinstance(item, datetime.date):
					dateString = item.strftime('%m/%d/%Y')
					outputString = outputString + dateString + " "
				elif isinstance(item, datetime.timedelta):
					timeString = secondsToString(item, '%H:%M:%S') + " "
					outputString = outputString + timeString
				else:
					outputString = outputString + str(item) + " "
		outputString = outputString + '\n'
	print(outputString)
	await ctx.send(outputString)

@bot.command()
async def userInfo(ctx, *args):
	cursor = dbLink.cursor()
	if len(args) != 3:
		await ctx.send("Not enough user information was provided. Please try again.")

	print(str(args[0]))
	print(str(args[1]))
	print(str(args[2]))
	query = "call outputUserInformation(\'" + str(args[0]) + "\',\'" + str(args[1]) + "\',\'" + str(args[2]) + "\')"
	cursor.execute(query)
	results = cursor.fetchall()

	outputString = ""
	if len(results) == 0:
		await ctx.send("There is no user that satisfies the provided input. Try something else.")
	for item in results:
		outputString = outputString + str(item) + " "
	
	print(outputString)
	await ctx.send(outputString)
@bot.command()
async def createUser(ctx, *args):
	cursor = dbLink.cursor()
	if len(args) != 5:
		await ctx.send("Not enough user information was provided. Please try again.")
	isTaken = False
	firstName = str(args[0])
	lastName = str(args[1])
	userpassword = str(args[2])
	userName = str(args[3])
	DOB = str(args[4])
	query1 = "select * from customer"
	cursor.execute(query1)
	results = cursor.fetchall()
	for user in results:
		if user[3] == userName:
			isTaken = True
			await ctx.send("An account with this username has already been created")
	if isTaken == False:
		newID = ""
		query = "call userCreation(\'" + firstName + "\',\'" + lastName + "\',\'" + userpassword + "\',\'" + userName + "\',\'" + DOB + "\')"
		cursor.execute(query)
		dbLink.commit()
		query2 = "select * from customer"
		cursor.execute(query2)
		results2 = cursor.fetchall()
		for user2 in results2:
			if user2[3] == userName:
				newID = user2[0]
		await ctx.send("Your account has been created, your user ID is " + newID)
	
@bot.command()
async def addOneWayBooking(ctx, *args):
	cursor = dbLink.cursor()
	if len(args) != 6:
		await ctx.send("Not enough user information was provided. Please try again.")
	origin = str(args[0])
	destination = str(args[1])
	accNum = str(args[2])
	bDate = str(args[3])
	custID = str(args[4])
	flightID = str(args[5])
	query2 = "call outputOneWayFlights(\'" + origin + "\',\'" + destination + "\',\'" + accNum + "\',\'" + bDate + "\',@isEmpty)"
	cursor.execute(query2)
	query3 = "select * from oneWayFlightOutput"
	cursor.execute(query3)
	results = cursor.fetchall()
	if not results:
		await ctx.send("No flights matching your criteria")
	else:
		customersBookingId = ""
		query = "call addOneWayBooking(\'" + origin + "\',\'" + destination + "\',\'" + accNum + "\',\'" + bDate + "\',\'" + custID + "\',\'" + flightID + "\')"
		
		cursor.execute(query)
		dbLink.commit()
		query4 = "select * from booking"
		cursor.execute(query4)
		results2 = cursor.fetchall()
		for flight in results2:
			print(flight)
			if flight[2] == origin and flight[3] == destination and flight[6] == custID:
				customersBookingId = flight[0]
		await ctx.send("Flight created for " + custID + " to " + destination + " on the day of " + bDate+ ". Your booking ID is " +
						 customersBookingId + ". Please record this ID, you may need it for cancellation.")

@bot.command()
async def cancelFlight(ctx, *args):
	cursor = dbLink.cursor()
	isThere = False
	if len(args) != 4:
		await ctx.send("Not enough parameters were provided. Please try again.")
	query = "call cancelFlight(\'" + str(args[0]) + "\',\'" + str(args[1]) + "\',\'" + str(args[2]) + "\',\'" + args[3] + "\')"
	query2 = "select * from booking"
	cursor.execute(query2)
	results = cursor.fetchall()
	for thing in results:
		if thing[0] == str(args[0]):
			isThere = True
	
	
	if isThere:
		cursor.execute(query)
		dbLink.commit()
		await ctx.send("Flight " + str(args[0]) + " for user ID " + str(args[1]) + " has been canceled" )
	else:
		await ctx.send("There are no flights with that ID")
	

@bot.command()
async def oneWaySearch(ctx, *args):
    cursor = dbLink.cursor()
    if len(args) != 4:
        await ctx.send("Not enough parameters were provided. Please try again.")
    
    query = "call outputOneWayFlights(\'" + str(args[0]) + "\',\'" + str(args[1]) + "\',\'" + args[2] + "\',\'" + str(args[3]) + "\',@isEmpty)"
    cursor.execute(query)
    query1 = "select * from oneWayFlightOutput"
    cursor.execute(query1)
    results = cursor.fetchall()

    outputString = ""
	
    for row in results:
        try:
            outputString.join(row)
        except TypeError:
            for item in row:
                if isinstance(item, datetime.date):
                    dateString = item.strftime('%m/%d/%Y')
                    outputString = outputString + dateString + " "
                elif isinstance(item, datetime.timedelta):
                    timeString = secondsToString(item, '%H:%M:%S') + " "
                    outputString = outputString + timeString
                else:
                    outputString = outputString + str(item) + " "
        outputString = outputString + '\n'
    if outputString == "":
        await ctx.send("No flights match criteria")
    else:
        await ctx.send(outputString)
	



bot.run('NzA1MTU5MjQ0NDY2NjE4NDAx.Xqno2Q.cirfjIIylV1nAfXAT1iybN-33o0')
