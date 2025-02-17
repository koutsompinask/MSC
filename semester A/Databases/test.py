import qrcode

# Website URL
url = "https://www.apomesimero.gr/"

# Create a QR code instance
qr = qrcode.QRCode(
    version=1,  # Controls the size of the QR code (1 is the smallest)
    error_correction=qrcode.constants.ERROR_CORRECT_L,  # Low error correction
    box_size=10,  # Size of each box in pixels
    border=4,  # Border thickness (default is 4)
)

# Add data to the QR code
qr.add_data(url)
qr.make(fit=True)

# Create and save the QR code image
img = qr.make_image(fill_color="white", back_color="#4b382b")
img.save("qr_code.png")

# Show the QR code
img.show()
