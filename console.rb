require('pry-byebug')
require_relative('models/property_crud')


property1 = PropertyCrud.new({'address' => '1, France Drive',
                              'value' => 1000000,
                              'bedrooms' => 5,
                              'build' => 'detached'
                            })

property2 = PropertyCrud.new({'address'=> 'Mullholand Drive',
                            'value' => 1500400,
                            'bedrooms' => 3,
                            'build' => 'semi-detached'})



property1.save()
property2.save()

property1.address = 'elm street'

property1.update()


property1.delete()

found=  PropertyCrud.find(2)[0]

p found.address

p PropertyCrud.find_by_address('1, France Drive')
p PropertyCrud.find_by_address('1, Fance Drive')
#p PropertyCrud.all()
