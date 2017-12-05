platform :ios, '10.0'
use_frameworks!

# ignore warnings from all pods.
inhibit_all_warnings!

def pods
end

def tests_pods
	pod 'KIF', '3.6.0'
	pod 'FBSnapshotTestCase', '2.1.4'
end

target 'BoilerplateWars' do
	pods
end

target 'BoilerplateWarsTests' do
	pods
	tests_pods
end
