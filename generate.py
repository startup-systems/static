import os,sys
def generate(inputFile, OutPutFolder, templateFile):
	
    #read in the input file
    i = open(inputFile, 'r')

    #create output file
    ofName = os.path.basename(inputFile)
    ofName = ofName.split('.')[0] + '.html'
    o = open(OutPutFolder + '/' + ofName, 'w')

    #read template file
    t = open(templateFile, 'r')

    title = ''
    body = ''
    c = 0
    for f in i:
        if len(f.strip()) == 0:
            c = 1
        elif c == 0:
            title += f + '\n'
        elif (c == 1):
            body+= f + '\n'
    print (body)
    print (title)
    c1 = 0
    c2 = 0
    #write in the output file
    for f in t:
        #put in control blocks to insert the title and body
        if 'title' in f and c1 ==0:
            o.write('<title>%s</title>\n'%(title))
            c1 = 1
        elif 'body' in f and c2 == 0:
            o.write('<body>%s</body>\n'%(body))
            c2 = 1
        elif not('title' in f or 'body' in f):
            o.write(f)

def main(inputFolder, outputFolder, templateFile):
    for x in os.listdir(inputFolder):
        iF = inputFolder + '/' + x 
        generate(iF, outputFolder, templateFile)


if __name__ == '__main__':
    x = ((sys.argv))

    inputFolder =str(x[1])
    outputFolder =str(x[2])

    print (inputFolder)
    print (outputFolder)
    main(inputFolder, outputFolder, 'template.html')
