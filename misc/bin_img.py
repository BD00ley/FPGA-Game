import os
from PIL import Image
picture = Image.open('test_pic.png')
binary_pic = open('test_pic.bin', 'wb')
binary_pic.write(picture.tobytes())
os.system("hexdump -v -C test_pic.bin | awk '{print $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17}' > test.txt")