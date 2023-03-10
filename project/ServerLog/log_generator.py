import time
import datetime
import random
import numpy
from faker import Faker

directory = './log/'
log_lines = 1200

response = ["200", "201", "300", "301", "308", 
			"400", "401", "403", "404", "407", 
			"408", "500", "502", "503", "504"]

method = ["GET", "POST", "DELETE", "PUT"]
resource = ["/api/customers/", "/api/orders/", "/api/products/", "/api/suppliers/"]
protocol = ["HTTP/1.1", "HTTP/2.0"]

user_identifier = "-"
#username = ["katie", "anthony", "rcaliandro", "spongebob", "santoro", "sonia", "oconnell", "john", "patrick", "andrea"]
#username = ["imattiassii2", "ipetchk9", "jdwelley1a", "kberthodm5", "kprattindx", "lhebburned", "lmclachlan6l", "mjimmes44", "mlakinf2", "mreubbens9v"]
#username = ["aarmfieldgu", "abarrow6m", "adimanche3n", "ajouhancn", "atillmandl", "atschierasche9h", "avartyrf", "bhansley8t", "bsandercock8e", "bwhaplingtonig"]
username = ["bworttkh", "byurov45", "carndtsend8", "cmattioni4y", "lfliggj6", "lginglescr", "lginie2n", "lmcauslan2s", "lsugdenny", "mbollom38"]
last_time = datetime.datetime.now()
time_str = time.strftime("%Y%m%d-%H%M%S")

faker = Faker()

user_agent = [faker.chrome, faker.opera, faker.internet_explorer, faker.safari, faker.firefox]

out_filename = directory + 'access_log_' + time_str + '.log'

file = open(out_filename, 'w')

#file.write('Test Log')


for i in range(0, log_lines):
	current_ip = faker.ipv4()
	last_time += datetime.timedelta(seconds=random.randint(1, 120))
	current_method = numpy.random.choice(method, p=[0.7, 0.05, 0.05, 0.2])
	current_response = numpy.random.choice(response,p=[0.7, 0.00125, 0.00125, 0.00125, 0.00125, 
													   0.02, 0.02, 0.02, 0.06, 0.02, 
													   0.035, 0.03, 0.02, 0.04, 0.03])

	current_username = numpy.random.choice(username, p=[0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1])

	current_method = numpy.random.choice(method, p=[0.7, 0.12, 0.06, 0.12])
	current_resource = numpy.random.choice(resource, p=[0.25, 0.25, 0.25, 0.25])
	current_protocol = numpy.random.choice(protocol, p=[0.86, 0.14])
	current_request = '"' + current_method + ' ' + current_resource + ' ' + current_protocol + '"'
	
	current_bytes = int(random.gauss(7000,20))
	current_referer = '"' + faker.uri() + '"'
	current_useragent = '"' + numpy.random.choice(user_agent, p=[0.5,0.05,0.05,0.1,0.3] )() + '"'


	file.write('%s %s %s [%s] %s %s %s %s %s\n' % (current_ip, user_identifier, current_username,
			last_time, current_request, current_response, current_bytes, current_referer, current_useragent))

	file.flush()
	"""print(current_ip + "|" + user_identifier + "|" + current_username + "|" 
		+ str(last_time) + "|" + current_request + "|" + str(current_bytes)
		+ "|" + current_referer + "|" + current_useragent + "|") """