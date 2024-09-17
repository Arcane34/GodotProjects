extends Control

var image_texture: ImageTexture
var imageRes = 256
var spacing = 40
var howBig = 20
var priorityQueue = []
var maximumVal = 32

var borderSize = 50
var borderWidth = 5

func create_border():
	var image = Image.create(imageRes, imageRes, false, Image.FORMAT_RGBA8)
	image.fill(Color.WHITE)
	
	for i in range(1):
		var borderOffset = (imageRes - borderSize) /2
		image.fill_rect(Rect2(borderOffset ,borderOffset, borderSize, borderSize), Color.BLACK)
		image.fill_rect(Rect2(borderOffset + borderWidth,borderOffset + borderWidth, borderSize - borderWidth*2, borderSize - borderWidth*2), Color.WHITE)
		
	
	return image
	


func create_image():
	var image = Image.create(imageRes, imageRes, false, Image.FORMAT_RGBA8)  # set imageres to 64
	#image.fill(Color.BLACK)
	var colorIn = true
	
	image.fill(Color.WHITE)
	
	image.fill_rect(Rect2(howBig,howBig,imageRes-2*howBig ,imageRes-2*howBig - 10), Color.BLACK)
	return image

func _ready():
	#var image = create_image()
	#var image = Image.load_from_file("res://assets/frogatto.png")
	var image = create_border()
	#var sdf = image
#
	#image = put_smallImg_to_bigImg(image)
	
	
	# Signed Distance Field Generation
	
	var pixels = get_outline(image) 
	
	pixels =  get_outline_borders( pixels )
	first_pass_priorQueue(pixels)
	
	
	
	pixels = compute_sdf(pixels)
	pixels = normaliseP(pixels)
	
	#getRange(pixels)
	
	var sdf = set_image_from_pixels(pixels)
	#sdf.save_png("C:/MyActualFiles/Aarogya/art/standalone/test.png")  # save image of sdf
	
	
	
	image_texture = ImageTexture.create_from_image(sdf)
	$Sprite2D.texture = image_texture
	


func put_smallImg_to_bigImg(smallImg):
	var bigSize = 256
	var bigImg = Image.create(bigSize, bigSize, false, Image.FORMAT_RGBA8)
	bigImg.fill(Color.WHITE)
	
	var hOffset = bigSize / 2 - smallImg.get_width()/2
	var vOffset = bigSize / 2 - smallImg.get_width()/2
	for row in range(smallImg.get_width()):
		for col in range(smallImg.get_width()):
			bigImg.set_pixel(row + hOffset, col + vOffset, smallImg.get_pixel(row ,col))
	
	
	return bigImg

func getRange(pixels):
	var lengths = []
	for row in pixels:
		for pixel in row:
			lengths.append(pixel[2].length())
	
	print(lengths.max(), " ", lengths.min())



func getNeighbours(ind, array) : #get neighbour list items from an array given the index
	
	var neighbours = []
	# ind[0] is row    ind[1] is column
	for row in 3:
		for col in 3:
			if not(col == 1 and row == 1):
				if ind[0] + row - 1 < len(array)-1 and ind[1] + col -1 < len(array[0])-1:
					neighbours.append([ array[ ind[0] + row - 1][ ind[1] + col - 1], Vector2(col - 1,row - 1 ), [ ind[0] + row - 1, ind[1] + col -1] ])
	
	return neighbours
			
func getImageNeighbourValues(ind, image):
	var neighbourValues = []
	# ind[0] is row    ind[1] is column
	for row in 3:
		for col in 3:
			if not(col == 1 and row == 1):
				var value = image.get_pixel( ind[0]  + row - 1  , ind[1] + col -1).r
				neighbourValues.append(value)
				
	return neighbourValues
			

func first_pass_priorQueue(pixels):
	for row in len(pixels):
		for col in len(pixels[row]):
			if !pixels[row][col][1]:
				var neighbours = getNeighbours([row, col], pixels)
				
				for neighbour in neighbours:
					if neighbour[0][1] and !( [ row, col ] in priorityQueue):
						priorityQueue.append([ row , col ])
						

func normaliseP(pixels):
	for row in len(pixels):
		for col in len(pixels[row]):
			var neighbours = getNeighbours([row,col], pixels)
			for neighbour in neighbours:
				if neighbour[0][1]:
					var newVec = neighbour[1] + neighbour[0][2]
					if pixels[row][col][2] != Vector2.ZERO:
						if pixels[row][col][2].length() > newVec.length():
							if newVec.length() > maximumVal:
								maximumVal = int(newVec.length())
							pixels[row][col] [2] =  newVec
					else:
						pixels[row][col] [2] =  newVec
						if newVec.length() > maximumVal:
							maximumVal = int(newVec.length())
			
	return pixels

func compute_sdf(pixels):
	var counter = 0
	while len(priorityQueue) > 0:
		counter += 1
		var currentPixel = pixels[priorityQueue[0][0]][priorityQueue[0][1]]
		var neighbours = getNeighbours(priorityQueue[0], pixels)
		
		for neighbour in neighbours:
			if !neighbour[0][1] and !(neighbour[2] in priorityQueue):
				priorityQueue.append(neighbour[2])
				
			else:
				if neighbour[0][1]:
					var newVec = neighbour[1] + neighbour[0][2]
					if currentPixel[2] != Vector2.ZERO:
						if currentPixel[2].length() > newVec.length():
							pixels[ priorityQueue [0] [0] ] [ priorityQueue [0] [1] ] [2] =  newVec
					else:
						pixels[ priorityQueue [0] [0] ] [ priorityQueue [0] [1] ] [2] =  newVec
					
		pixels[priorityQueue[0][0]][priorityQueue[0][1]][1] = true
		#print(pixels[priorityQueue[0][0]][priorityQueue[0][1]])
		priorityQueue.pop_at(0)
		
		#if counter > 4000:
			#break
	
	#print(counter)
	return pixels
	
	#while len(priorityQueue) > 0:
		#counte += 1
		#
		#var row = -1
		#var col = -1
		#for l in 9:
			#if col > 1 or priorityQueue[0][0] + col > len(pixels)-1:  #update counters
				#row += 1
				#col = -1
				#if priorityQueue[0][1] + row > len(pixels[0])-1:
					#break
					#
			#if l == 4:
				#col += 1
				#continue
				#
			#if !pixels[priorityQueue[0][0] + col][priorityQueue[0][1] + row][1] and !([priorityQueue[0][0] + col, priorityQueue[0][1] + row] in priorityQueue):  #if neighbours not checked add to list
				#priorityQueue.append([priorityQueue[0][0] + col, priorityQueue[0][1] + row])
				#
			#else: #if neighbour checked, compute self distance
				#var newVector = Vector2(col,row) + pixels[priorityQueue[0][0] + col][priorityQueue[0][1] + row][2]
				#print(pixels[priorityQueue[0][0] + col][priorityQueue[0][1] + row][2]  , " || ", Vector2(col,row))
				##print(newVector, pixels[priorityQueue[0][0] + col][priorityQueue[0][1] + row][2])
				#if pixels[priorityQueue[0][0]][priorityQueue[0][1]][2] != Vector2.ZERO:
					#if pixels[priorityQueue[0][0]][priorityQueue[0][1]][2].length() > newVector.length():
						#pixels[priorityQueue[0][0]][priorityQueue[0][1]][2] = newVector
				#else:
					#pixels[priorityQueue[0][0]][priorityQueue[0][1]][2] = newVector
				#print(newVector.length())
				#
			#col += 1
		#
		#pixels[priorityQueue[0][0]][priorityQueue[0][1]][1] = true
		#priorityQueue.pop_at(0)
		#print(counte , " ", 64*64)
		#if counte > 10:
			#break


func get_outline_borders(pixels):
	for row in len(pixels):
		for col in len(pixels[row]):
			if pixels[row][col][0] != 1:
				
				var neighbours = getNeighbours([ row, col ], pixels)
				var nearBorder = false
				for neighbour in neighbours:
					if neighbour[0][0] == 1:
						pixels[row][col][1] = true
						if pixels[row][col][2] != Vector2.ZERO:
							
							if pixels[row][col][2].length() > neighbour[1].length():
								pixels[row][col][2] = neighbour[1]
						else:
							pixels[row][col][2] = neighbour[1]
							
	return pixels


func get_outline(image):
	
	var pixels = []
	
	for row in range(image.get_width()):
		var temp = []
		for col in range(image.get_width()):
			var pixel = image.get_pixel(row,col)
			if pixel.r == 1:
				temp.append([0,false, Vector2.ZERO])  #outside the shape
			else:
				var outline = false
				
				var neighbours =  getImageNeighbourValues( [ row, col ], image)
			
				if 1.0 in neighbours:
					temp.append([1,true,Vector2.ZERO])  # outline
				else:
					temp.append([-1,false,Vector2.ZERO])  # inside

		pixels.append(temp)
	
	return pixels


func set_image_from_pixels(pixels):
	var image = Image.create(len(pixels), len(pixels), false, Image.FORMAT_RGBA8)
	
	var counter = 0
	for i in len(pixels):
		for j in len(pixels[i]):
			#if pixels[i][j][0] == -1:
				#image.set_pixel(i,j, Color.GRAY)
			#else:
				#image.set_pixel(i,j,Color(pixels[i][j][0], pixels[i][j][0], pixels[i][j][0], 1.0))
			#
			#
			#if pixels[i][j][2] == Vector2.ZERO:
				#counter += 1
			#
			var c = pixels[i][j][2].length() / maximumVal
			#if pixels[i][j][0] == -1:
				#c = c * pixels[i][j][0]
			
			image.set_pixel(i,j, Color(c,c,c) )
	
	print(counter)
	for i in priorityQueue:
		image.set_pixel(i[0],i[1], Color(.0,1.0,.0))
		
	return image
	
	
	
	
